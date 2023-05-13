#!/bin/bash

docker build -t quiz-app .
docker run -p 3000:3000 quiz-app

