#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools

# link default training data for easier access

mkdir -p $data/gl_aviser

for corpus in train valid test; do
    absolute_path=$(realpath $tools/pytorch-examples/word_language_model/data/gl_aviser/$corpus.txt)
    ln -snf $absolute_path $data/gl_aviser/$corpus.txt
done

 # download a different interesting data set!

mkdir -p $data/gl_aviser
mkdir -p $data/gl_aviser/raw

wget https://www.dropbox.com/s/f0ag89gn0zlmf6b/gl_aviser.txt?dl=0
mv gl_aviser.txt $data/gl_aviser/raw

# preprocess slightly

cat $data/gl_aviser/raw/gl_aviser.txt | python $base/scripts/preprocess_raw.py > $data/gl_aviser/raw/gl_aviser.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/gl_aviser/raw/gl_aviser.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 5000 --tokenize > \
    $data/gl_aviser/raw/gl_aviser.preprocessed.txt

# split into train, valid and test

head -n 500 $data/gl_aviser/raw/gl_aviser.preprocessed.txt > $data/gl_aviser/valid.txt
head -n 1000 $data/gl_aviser/raw/gl_aviser.preprocessed.txt | tail -n 500 > $data/gl_aviser/test.txt
tail -n 3260 $data/gl_aviser/raw/gl_aviser.preprocessed.txt > $data/gl_aviser/train.txt
