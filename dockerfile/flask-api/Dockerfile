FROM python:2.7
LABEL version="0.1"
WORKDIR /usr/src/app
COPY . /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
RUN mkdir test
VOLUME ["test"] 
CMD [ "python", "api.py"]
