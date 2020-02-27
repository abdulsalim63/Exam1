FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY RefactoryExam1/RefactoryExam1.csproj RefactoryExam1/
RUN dotnet restore "RefactoryExam1/RefactoryExam1.csproj"
COPY . .
WORKDIR "/src/RefactoryExam1"
RUN dotnet build "RefactoryExam1.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "RefactoryExam1.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "RefactoryExam1.dll"]
