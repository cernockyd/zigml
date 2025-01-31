# MNIST Neural Classifier from scratch

A classifier of MNIST created as subgoal of implementing Rumelhart et al. 1986 paper on backpropagation.

## Get started

get data

```bash
curl -L -o data.zip https://www.kaggle.com/api/v1/datasets/download/oddrationale/mnist-in-csv
mkdir data && tar xf data.zip -C data
```

run

```bash
zig build run -Doptimize=ReleaseFast
```
