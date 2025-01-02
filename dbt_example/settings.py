from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env", env_file_encoding="utf-8", extra="ignore"
    )
    DBT_DBNAME: str
    DBT_USER: str
    DBT_PASS: str
    DBT_HOST: str
    DBT_PORT: int =5432
    DBT_PROFILES_DIR: str
    