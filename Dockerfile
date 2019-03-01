FROM microsoft/dotnet:2.2-sdk-bionic AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY pitt-boss/*.csproj ./pitt-boss/
COPY utils/*.csproj ./utils/
WORKDIR /app/pitt-boss
RUN dotnet restore

# copy and publish app and libraries
WORKDIR /app/
COPY pitt-boss/. ./pitt-boss/
COPY utils/. ./utils/
WORKDIR /app/pitt-boss
RUN apt-get update -yq && apt-get upgrade -yq && apt-get install -yq curl git vim
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && apt-get install -yq nodejs build-essential
RUN npm install -g npm
RUN npm install
RUN dotnet publish -c Release -o out


# test application -- see: dotnet-docker-unit-testing.md
FROM build AS testrunner
WORKDIR /app/tests
COPY tests/. .
ENTRYPOINT ["dotnet", "test", "--logger:trx"]


FROM microsoft/dotnet:2.2-aspnetcore-runtime-bionic AS runtime
WORKDIR /app
COPY --from=build /app/pitt-boss/out ./
ENTRYPOINT ["dotnet", "pitt-boss.dll"]

