FROM python:stretch

MAINTAINER Anthony Rozon <arozonm@gmail.com>

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        xvfb \
        unzip \
        openjdk-8-jre-headless

# Install Chrome
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get -y update && apt-get -y install google-chrome-stable

# Setup version variables
ENV CHROMEDRIVER_VERSION 2.44
ENV ALLURE_VERSION 2.7.0
# Download ChromeDriver
RUN wget http://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN rm chromedriver_linux64.zip

# Install ChromeDriver
RUN mv chromedriver /usr/local/bin/chromedriver
RUN chown root:root /usr/local/bin/chromedriver
RUN chmod 0755 /usr/local/bin/chromedriver

# Download Allure binaries
RUN wget -O allure-${ALLURE_VERSION}.zip https://github.com/allure-framework/allure2/releases/download/${ALLURE_VERSION}/allure-${ALLURE_VERSION}.zip
RUN unzip allure-${ALLURE_VERSION}.zip
RUN rm allure-${ALLURE_VERSION}.zip

WORKDIR /