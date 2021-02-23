import collections
import time
import numpy as np
import grpc
import sys
import absl

import tensorflow as tf
import tensorflow_federated as tff

import nest_asyncio
nest_asyncio.apply()

@tff.tf_computation(tf.int64)
@tf.function
def add_one(n):
    tf.print("Hello: ", n, output_stream=absl.logging.info)
    return tf.add(n, 1)


@tff.federated_computation(tff.FederatedType(tf.int64, tff.CLIENTS))
def add_one_on_clients(federated_n):
    return tff.federated_map(add_one, federated_n)



print(add_one_on_clients([1]))