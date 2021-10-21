FROM nvidia/cuda:10.2-cudnn8-devel

ENV APP_HOME /
WORKDIR $APP_HOME

RUN apt-get update
RUN apt-get install --yes git curl build-essential wget

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b

ENV PATH=$PATH:/root/miniconda3/bin

RUN conda install -y cudatoolkit=10.2 -c nvidia
RUN conda install -y pytorch torchvision torchaudio -c pytorch -c nvidia
RUN conda install -y pytorch-lightning -c conda-forge

COPY requirements.txt ./
RUN pip install --no-cache-dir -r ./requirements.txt

RUN git clone https://github.com/openai/CLIP
RUN git clone https://github.com/CompVis/taming-transformers.git
RUN git clone https://github.com/BachiLi/diffvg

# Compile diffvg
WORKDIR diffvg
RUN git submodule update --init --recursive
RUN conda install -y numpy
RUN conda install -y scikit-image
RUN conda install -y -c anaconda cmake
RUN conda install -y -c conda-forge ffmpeg
RUN export DIFFVG_CUDA=1; python setup.py install
WORKDIR ..


# Clone clipit last, since it's the second most-likely to change
RUN git clone https://github.com/dribnet/clipit

RUN conda install -y -c conda-forge jupyterlab

# Copy local code to container image
# COPY *.py ./
# CMD ["python3", "pixeldraw.py"]