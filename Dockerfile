FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine as build
WORKDIR /app

# copy csproj and restore
COPY TestApi/*.csproj ./testapi/
RUN cd ./testapi/ && dotnet restore 

# copy all files and build
COPY TestApi/. ./testapi/
WORKDIR /app/testapi
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine as runtime
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT [ "dotnet", "TestApi.dll" ]