FROM python:3
LABEL version="0.1"
WORKDIR /usr/src/app
COPY . .
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
CMD [ "python", "api.py"]
