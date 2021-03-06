#!/bin/sh
KE=0.01
JF=0.01
DATA='imagenet64'
DATADIR='../data/'
SAVE=../experiments/$DATA/example/

NUM_GPUS=4

OMP_NUM_THREADS=5 \
python -m torch.distributed.launch \
  --nproc_per_node=$NUM_GPUS --nnodes=1 --node_rank=0 \
  ../train.py --data $DATA \
  --distributed \
  --log_freq 1 \
  --datadir $DATADIR \
  --batch_size 50 \
  --test_batch_size 50 \
  --num_epochs 4 \
  --save $SAVE \
  --kinetic-energy $KE \
  --jacobian-norm2 $JF \
  --alpha 0.05 \
  --test_solver dopri5 --test_atol 1e-5 --test_rtol 1e-5 \
