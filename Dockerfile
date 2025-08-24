FROM ghcr.io/cirruslabs/flutter:3.35.1

WORKDIR /app

COPY pubspec.* ./

RUN flutter pub get

COPY . .

RUN flutter doctor -v

CMD ["flutter", "run"]
