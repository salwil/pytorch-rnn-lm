# Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model).

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/salwil/pytorch-rnn-lm.git
    cd pytorch-rnn-lm

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/install_packages.sh

Download and preprocess data:

    ./scripts/download_data.sh

Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Generate (sample) some text from a trained model with:

    ./scripts/generate.sh


# Further Remarks

I did the steps with a textfile containing text of Greenlandic newspapers. File download link: https://www.dropbox.com/s/f0ag89gn0zlmf6b/gl_aviser.txt?dl=0

I did the steps several times, varying vocabulary at preprocessing and hyperparameters at training time. The best perplexity was reached with the try of vocabulary size 5000 and the following hyperparameters:
    - embedding size: 400
    - epochs: 40
    - dropout: 0.5

Actually I would have liked to work with a file with proper Greenlandic Inuktitut, as I would have been really interested in the results of the text generate module, which is actually built for English, which is a completely different type of language. But I was not able to find an textfile which was large enough. What I found was a lot of online news papers, but the articles are normally written in Greenlandic and Danish (and sometimes even in English). So besides that Greenlandic would already have a lot of unknown vocabulary itself (because it is an agglutinative language - sentences can consist of one or two very long "words", which are of course all a bit different from each other, so a very low probability results), it is enlarged by the Danish and English vocabulary. 

For the sample search there were still some "nice" result when generating text, but at greedy search it was kind of fail. It produced only unknown- and eof-tags. :(


### My notes to different training results

Training results with different hyperparameters and vocabulary size: 5000
```txt
*------------------------------------------------------------------*
| emb. size  |   epochs   |   dropout    |   ppl     |   model     |
|----------------------------------------------------|-------------| 
|    200     |     40     |     0.5      |  221.69   | model_1.pt  |
|----------------------------------------------------|-------------| 
|    400     |     40     |     0.5      |  137.60   | model_2.pt  | --> model to use
|----------------------------------------------------|-------------| 
|    200     |     40     |     0.5      |  221.69   | model_3.pt  |
|----------------------------------------------------|-------------| 
|    200     |     40     |     0.7      |  143.34   | model_4.pt  |
|----------------------------------------------------|-------------| 
|    400     |     40     |     0.7      |  140.32   | model_5.pt  |
|----------------------------------------------------|-------------| 
|    400     |     40     |     0.7      |  140.32   | model_6.pt  |
|----------------------------------------------------|-------------| 
|    500     |     40     |     0.8      |  138.47   | model_7.pt  |
|----------------------------------------------------|-------------| 
|    400     |     30     |     0.5      |  278.54   | model_8.pt  |
*------------------------------------------------------------------*

Training result with vocabulary size: 6000

*------------------------------------------------------------------*
| emb. size  |   epochs   |   dropout    |   ppl     |   model     |
|----------------------------------------------------|-------------| 
|    400     |     40     |     0.5      |  137.60   | model_2.pt  |
*------------------------------------------------------------------*


Training results with different hyperparameters and vocabulary size: 10000

-------------------------------------------------------------------*
| emb. size  |   epochs   |   dropout    |   ppl     |   model     |
|----------------------------------------------------|-------------|
|    200     |     40     |     0.5      |  288.08   | model_1.pt  |
|----------------------------------------------------|-------------| 
|    400     |     30     |     0.5      |  270.03   | model_2.pt  |
|----------------------------------------------------|-------------| 
|    500     |     30     |     0.5      |  286.96   | model_3.pt  |
|----------------------------------------------------|-------------| 
|    500     |     30     |     0.7      |  265.18   | model_4.pt  |
|----------------------------------------------------|-------------| 
|    300     |     40     |     0.4      |  278.54   | model_5.pt  |
*------------------------------------------------------------------*
```
