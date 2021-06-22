# Trans-SS

This repo contains codes, mined corpora and model checkpoints for paper "An Unsupervised Method for Building Sentence Simplification corpora in Multiple Languages".

## Requirements and Installation

This project is built with standard sentence simplification suite [EASSE](https://github.com/feralvam/easse) and sequence modeling toolkit [fairseq](https://github.com/pytorch/fairseq). Owing to that these two repo are still in fast developing,  we recommend you to use the same version of packages that we use for reproducing our work.

We provide two methods to install the required dependencies:

- python==3.7

### Method 1: pip install

```shell
pip install -r requirements.txt
```

### Method 2: build from source

1. Download the source code of dependencies from our OSS bin:

    ```shell
    wget -O "easse-master.zip" https://lxylab.oss-cn-shanghai.aliyuncs.com/Trans-SS/dependencies/easse-master.zip?Expires=1621655664&OSSAccessKeyId=TMP.3KhkXEk8sEea3ZTxbd31gJTuaBDoR2NwJKuAe1EkoET4T2dzSY4qV3AiTDuvQrSrs7MxJDQjffyE7W8vw39LPU7htfLJtP&Signature=j7ne9Zfrq9QAXWCQ5na%2F5cqk0Hs%3D&versionId=CAEQHBiBgMDk5pvHzBciIDg4NjJmZDUwOTc4MDQ4YmU4NTQ4N2MwYTBjMTcwNDhk&response-content-type=application%2Foctet-stream
    wget -O "fairseq.tar.gz" https://lxylab.oss-cn-shanghai.aliyuncs.com/Trans-SS/dependencies/fairseq.tar.gz?Expires=1621656526&OSSAccessKeyId=TMP.3KhkXEk8sEea3ZTxbd31gJTuaBDoR2NwJKuAe1EkoET4T2dzSY4qV3AiTDuvQrSrs7MxJDQjffyE7W8vw39LPU7htfLJtP&Signature=BozeCiZT9WoC4XazSRa0%2FxhsDk0%3D&versionId=CAEQHBiBgIDrjqTHzBciIGZjNThiNTc5ZmRhNzQ5NjFiZmYwMjFlOTUzYjBiMjA3&response-content-type=application%2Foctet-stream
    ```

2. Build from the source code:
    ```shell
    tar -xzvf fairseq.tar.gz
    cd fairseq/
    pip install -e ./
    ```

    ```shell
    unzip easse-master.zip
    cd easse-master/
    pip install -e ./
    ```


Additionally, the C++ API of [fastBPE](https://github.com/glample/fastBPE) is also needed for word segmentation.

```shell
cd fastBPE/
g++ -std=c++11 -pthread -O3 fastBPE/main.cc -IfastBPE -o fast
```

You can also watch the visualized training process using [tensorboard](https://github.com/tensorflow/tensorboard).

```shell
pip install tensorboard
```