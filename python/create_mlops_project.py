import os

project_name = "mlops_project"

folders = [
    "data",
    "notebooks",
    "src",
    "models",
    "mlflow_server",
    "infra",
    "serving",
    ".github/workflows",
]

files = {
    "README.md": "# MLOps Project\n\nEnd-to-end MLOps pipeline project.",
    "requirements.txt": "scikit-learn\nmlflow\ndvc\nfastapi\nuvicorn\njoblib\n",
    "dvc.yaml": "stages:\n  preprocess:\n    cmd: python src/data_preprocessing.py\n    deps:\n      - data/raw_data.csv\n    outs:\n      - data/processed_data.csv\n",
    "src/data_preprocessing.py": "# Preprocess raw data\n",
    "src/train.py": "# Train model and log to MLflow\n",
    "src/evaluate.py": "# Evaluate model and output metrics\n",
    "src/predict.py": "# Predict using trained model\n",
    "serving/app.py": """\
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "MLOps Model Serving Ready"}
""",
    "serving/Dockerfile": """\
FROM python:3.9

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["uvicorn", "serving.app:app", "--host", "0.0.0.0", "--port", "8080"]
""",
    ".github/workflows/mlops_pipeline.yml": """\
name: MLOps CI/CD

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    - run: pip install -r requirements.txt
    - run: python src/train.py
""",
}

def create_structure():
    print(f"Creating project: {project_name}")
    os.makedirs(project_name, exist_ok=True)
    os.chdir(project_name)

    for folder in folders:
        os.makedirs(folder, exist_ok=True)
        print(f"Created folder: {folder}")

    for file_path, content in files.items():
        file_dir = os.path.dirname(file_path)
        if file_dir:
            os.makedirs(file_dir, exist_ok=True)
        with open(file_path, "w") as f:
            f.write(content)
        print(f"Created file: {file_path}")

if __name__ == "__main__":
    create_structure()

