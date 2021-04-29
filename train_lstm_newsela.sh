wget -P './bpe' -N 'https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/encoder.json'
wget -P './bpe' -N 'https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/vocab.bpe'
wget -P './bpe' -N 'https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/dict.txt'

TASK=ts-newsela

if [ "$1" != "no-preprocess" ]; then
    
    # BPE
    if [ ! -d "./${TASK}/" ]; then
        mkdir ${TASK}
    fi
    for split in 'train' 'test' 'valid'; do
        for type in 'src' 'dst'; do
            python -m bpe.multiprocessing_bpe_encoder \
            --encoder-json ./bpe/encoder.json \
            --vocab-bpe ./bpe/vocab.bpe \
            --inputs ./datasets/newsela/newsela.${split}.${type} \
            --outputs ./${TASK}/${split}.bpe.${type} \
            --workers 60 \
            --keep-empty;
        done
    done
    
    # preprocess

    fairseq-preprocess \
      --source-lang "src" \
      --target-lang "dst" \
      --trainpref "${TASK}/train.bpe" \
      --testpref "${TASK}/test.bpe" \
      --validpref "${TASK}/valid.bpe"  \
      --destdir "${TASK}-bin/" \
      --workers 60 \
      --srcdict ./bpe/dict.txt \
      --tgtdict ./bpe/dict.txt;
    
fi

# Training

LR=0.0005
MAX_TOKENS=12000
UPDATE_FREQ=1
MAX_UPDATE=15000
WARMUP_UPDATES=300

CUDA_VISIBLE_DEVICES=0 python ./train.py ${TASK}-bin/ \
    --source-lang "src" \
    --target-lang "dst" \
    --bpe "gpt2" \
    --arch lstm --save-dir "./checkpoints/newsela/lstm/" \
    --tensorboard-logdir "./logs/tensorboard/newsela/lstm/" \
    --dropout 0.1 \
    --optimizer adam --lr ${LR} \
    --lr-scheduler polynomial_decay \
    --total-num-update ${MAX_UPDATE} --warmup-updates ${WARMUP_UPDATES} \
    --validate-interval 1 \
    --max-tokens ${MAX_TOKENS} \
    --max-epoch 15 \
    --gpt2-encoder-json "./bpe/encoder.json" \
    --gpt2-vocab-bpe "./bpe/vocab.bpe"