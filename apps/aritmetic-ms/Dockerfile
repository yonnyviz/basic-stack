FROM node:14
WORKDIR /usr/src/app
COPY ./src .
RUN npm install
EXPOSE 3000
CMD [ "npm", "start" ]
HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:3000/health || exit 1