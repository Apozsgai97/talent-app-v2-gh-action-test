
FROM node:18 AS build

WORKDIR /src

COPY package*.json ./


RUN npm install --legacy-peer-deps


COPY . .

ARG VITE_REACT_APP_TEST_1
ARG DATABASE_URL
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG NEXT_PUBLIC_FEATURE_BIO
ARG GOOGLE_API_KEY
ARG NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY
ARG CLERK_SECRET_KEY
ARG NEXT_PUBLIC_CLERK_SIGN_IN_URL
ARG NEXT_PUBLIC_CLERK_SIGN_UP_URL
ARG FEATURE_PERFORMANCE_TEST

ENV VITE_REACT_APP_TEST_1=${VITE_REACT_APP_TEST_1}
ENV DATABASE_URL=${DATABASE_URL}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV NEXT_PUBLIC_FEATURE_BIO=${NEXT_PUBLIC_FEATURE_BIO}
ENV GOOGLE_API_KEY=${GOOGLE_API_KEY}
ENV NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=${NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY}
ENV CLERK_SECRET_KEY=${CLERK_SECRET_KEY}
ENV NEXT_PUBLIC_CLERK_SIGN_IN_URL=${NEXT_PUBLIC_CLERK_SIGN_IN_URL}
ENV NEXT_PUBLIC_CLERK_SIGN_UP_URL=${NEXT_PUBLIC_CLERK_SIGN_UP_URL}
ENV FEATURE_PERFORMANCE_TEST=${FEATURE_PERFORMANCE_TEST}

RUN npm run build

FROM nginx:alpine


COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /src/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
