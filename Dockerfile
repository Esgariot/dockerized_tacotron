FROM python:3.6.0
ARG SPEECH_URI=http://data.keithito.com/data/speech/LJSpeech-1.1.tar.bz2
ENV SPEECH_URI_VARIABLE=${SPEECH_URI}
WORKDIR /root/tacotron/
ADD tacotron .
RUN pip install --upgrade pip
RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.10.1-cp36-cp36m-linux_x86_64.whl
RUN pip install --upgrade -r requirements.txt
ADD ${SPEECH_URI_VARIABLE} .
RUN tar xvjf LJSpeech-1.1.tar.bz2
RUN python preprocess.py --dataset ljspeech
CMD python train.py
