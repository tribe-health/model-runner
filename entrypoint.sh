#!/bin/bash

# Check if the MODEL_PATH and PORT environment variables are set
if [ -z "$MODEL_PATH" ]; then
  echo "Error: MODEL_PATH environment variable is not set."
  exit 1
fi

if [ -z "$PORT" ]; then
  echo "Error: PORT environment variable is not set."
  exit 1
fi

# Run the llama.cpp server binary with the specified model and port
./llama-server --model "$MODEL_PATH" --port "$PORT"