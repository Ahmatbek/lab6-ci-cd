import os
class Config:
    SECRET_KEY = os.environ.get("SECRET_KEY")
    DB_HOST = os.environ.get("DB_HOST")
    DB_PORT = os.getenv("DB_PORT", "5432")
    DB_NAME = os.environ.get("DB_NAME")
    DB_USER = os.environ.get("DB_USER")
    DB_PASSWORD = os.environ.get("DB_PASSWORD")
    APP_ENV = os.getenv("APP_ENV", "production")
    DEBUG = os.getenv("DEBUG", "false").lower() == "true"

    @staticmethod
    def validate():
        required = ["SECRET_KEY", "DB_HOST", "DB_NAME", "DB_USER", "DB_PASSWORD"]
        missing = [var for var in required if not os.getenv(var)]
        if missing:
            raise Exception(f"Missing required variables: {missing}")
