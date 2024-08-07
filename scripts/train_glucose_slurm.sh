#!/bin/bash
#SBATCH --job-name=test
#SBATCH --time=2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
model_name=Mamba
learning_rate=0.001
llama_layers=32

master_port=8889
batch_size=64
d_model=16
d_ff=32

comment='TimeLLM-ECL'

eval "$(conda shell.bash hook)"
conda activate Time-LLM

python run_pl.py \
  --task_name short_term_forecast \
  --num_nodes 1 \
  --is_training 1 \
  --precision 32 \
  --root_path /home/yl2428/Time-LLM/dataset/glucose \
  --data_path_pretrain combined_data_Jun_28.csv \
  --data_path combined_data_Jun_28.csv \
  --model_id TimeLLM \
  --model $model_name \
  --data_pretrain Glucose \
  --features MS \
  --seq_len 128 \
  --label_len 12 \
  --pred_len 12 \
  --factor 3 \
  --enc_in 4 \
  --dec_in 4 \
  --c_out 1 \
  --des 'Exp' \
  --itr 1 \
  --d_model $d_model \
  --d_ff $d_ff \
  --batch_size $batch_size \
  --learning_rate $learning_rate \
  --llm_layers $llama_layers \
  --train_epochs 100 \
  --enable_covariates 1 \
  --model_comment $comment \
  --num_experts 4 \
  --stride 1 \
  --use_deep_speed 1 
