import nest_asyncio
nest_asyncio.apply()

import collections
import time
import os

import tensorflow as tf
import tensorflow_federated as tff
import grpc

from absl import logging
from absl import flags
from absl import app

FLAGS = flags.FLAGS
flags.DEFINE_string('client_ip', 'tff_worker', 'ip to connect to')
flags.DEFINE_integer('parallels', 1, 'parallel conenctions to workers')
flags.DEFINE_string('client_port', '8000', 'port to connect tp')
flags.DEFINE_string('rpcmode', 'STREAMING', 'rpc mode, either REQUEST_REPLY or STREAMING')

@tff.tf_computation
def make_data():

    print("MAKE DATA")    
    global_data_path = os.environ.get("TRAIN_DATA_PATH")    
    print("Load data from ", global_data_path)    
    data_path = tf.keras.utils.get_file("/tmp/train_dataset.csv", global_data_path)

    typeList = [tf.float32 for n in range(784)]
    typeList.insert(0,tf.int32)

    colList = [n for n in range(784)]
    colList.insert(0,"label")

    dataset = tf.data.experimental.make_csv_dataset(
        data_path,
        #column_names=colList,
        column_defaults=typeList,        
        label_name='label',
        batch_size=5,
        num_epochs=10,
        ignore_errors=True)

    def map_fn(x,y):
        x = tf.reshape(tf.stack([tf.cast(item,tf.float32) for item in list(x.values())], axis=1),[-1, 784])
        y = tf.reshape(y,[-1])
        return collections.OrderedDict(x=x, y=y)

    dataset = dataset.take(10).batch(20).map(map_fn)

    return dataset

@tff.federated_computation
def make_data_on_client():
    return tff.federated_eval(make_data, tff.CLIENTS)


def model_fn():
    
    print("Constructing Model")

    input_spec = collections.OrderedDict()
    input_spec["x"] = tf.TensorSpec(shape=(None,784), dtype=tf.float32)
    input_spec["y"] = tf.TensorSpec(shape=(None,), dtype=tf.int32)
    
    model = tf.keras.models.Sequential([
        tf.keras.layers.InputLayer(input_shape=(784,)),
        tf.keras.layers.Dense(units=10, kernel_initializer='zeros'),
        tf.keras.layers.Softmax(),
    ])
    
    return tff.learning.from_keras_model(
        model,
        input_spec=input_spec,
        loss=tf.keras.losses.SparseCategoricalCrossentropy(),
        metrics=[tf.keras.metrics.SparseCategoricalAccuracy()])


def trainFederated(trainer, num_rounds=10):
    parallels  = FLAGS.parallels
    client_idxs = [n for n in range(parallels)]

    print("initializing trainer")
    state = trainer.initialize()
    print("trainer initialized")
    for round in range(num_rounds):
        print("Round {} started".format(round))
        t1 = time.time()
        #help(trainer)
        state, metrics = trainer.next(state,client_idxs) #[0] is a dummy parameter
        t2 = time.time()    
        
        print('Round {}:, round time {}, metrics={}'.format(round, t2 - t1, metrics))
def set_local_execution():
    parallels  = FLAGS.parallels

    print("Set local execution")
    tff.backends.native.set_local_execution_context(num_clients=parallels)

def set_remote_execution():
    ip_address = FLAGS.client_ip
    port       = FLAGS.client_port
    rpc_mode   = FLAGS.rpcmode
    parallels  = FLAGS.parallels
    
    print("Initializing channels and set backends")
    
    channels = [
        grpc.insecure_channel('0.0.0.0:8000'),
    ]
    tff.backends.native.set_remote_execution_context(channels, rpc_mode=rpc_mode)


def main(argv):

    set_remote_execution()
    
    print("creating trainer")
    trainer = tff.learning.build_federated_averaging_process(
        model_fn, 
        client_optimizer_fn=lambda: tf.keras.optimizers.SGD(0.02),
        server_optimizer_fn=lambda: tf.keras.optimizers.SGD(1.0))

    @tff.federated_computation(trainer.next.type_signature.parameter[0], tff.FederatedType(tf.int32, tff.CLIENTS))
    def new_next(server_state,dummy):
        preprocessed_data = make_data_on_client()
        return trainer.next(server_state, preprocessed_data)

    new_trainer = tff.templates.IterativeProcess(initialize_fn=trainer.initialize, next_fn=new_next)


    print("Start the traing and evaluation")
    trainFederated(new_trainer)


if __name__ == "__main__":
    app.run(main)
