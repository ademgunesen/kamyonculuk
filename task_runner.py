from os.path import join
import wandb
from main import main_task
from mlops_utils import derive_dataset_conf_parameters

device = "cuda:2"

dataset_conf = {}
model_conf = {}
training_conf = {}
augment_conf = {}

datasets_root = "/home/braincreator/daniel/ademgunesen/square_format"

dataset_conf['dataset_root']      = datasets_root
dataset_conf['preprocessed']      = False
dataset_conf['denoised']          = True
dataset_conf['PBDA']              = False
dataset_conf['cropped']           = True
dataset_conf['crop_size']         = 1152
dataset_conf['stride']            = 1152
dataset_conf['black_ratio']       = 100
dataset_conf['denoising_size']    = 4096
dataset_conf['resolution']        = 0
dataset_conf['data']              = "ma"
############################################################################################################
# Derived parameters : Do not change these
dataset_conf = derive_dataset_conf_parameters(dataset_conf)
############################################################################################################ 

model_conf['decoder']           = "FPN"
model_conf['encoder']           = "vgg19"
model_conf['encoder_weight']    = "imagenet"
model_conf['pretrained_weights']= False
model_conf['freeze_encoder']    = False
model_conf['activation']        = "sigmoid"

training_conf['batch_size'] = 1
training_conf['epoch'] = 40
training_conf['lr'] = 1e-4
training_conf['weight_decay'] = 1e-4



task_conf = {}
task_conf['dataset_conf'] = dataset_conf
task_conf['model_conf'] = model_conf
task_conf['training_conf'] = training_conf
task_conf['augment_conf'] = augment_conf

prepare_data_step = True
train_step = True
test_step = True
email_step = False

steps = [prepare_data_step,train_step,test_step,email_step]

main_task(task_conf,steps,device)