from os.path import join
from main import main_task

device = "cuda:0"

dataset_conf = {}
model_conf = {}
training_conf = {}
augment_conf = {}

datasets_root = "/home/adem/Desktop/Thesis/IDRiD Dataset Collection/Adamlarin Format"

dataset_conf['preprocessed']      = True
dataset_conf['denoised']          = False
dataset_conf['cropped']           = True
dataset_conf['crop_size']         = 256
dataset_conf['stride']            = 256
dataset_conf['black_ratio_train'] = 1 # TODO: Implement this
dataset_conf['denoising_size']    = 4096
dataset_conf['resolution']        = 0
dataset_conf['data']              = "ma"
############################################################################################################
# Derived parameters : Do not change these
if dataset_conf['denoised']:
    dir_annex = join('Denoised', f'all_{dataset_conf["denoising_size"]}')
elif dataset_conf['preprocessed']:
    dir_annex = 'Preprocessed'
else:
    dir_annex = 'Orjinal'
dataset_conf['train_image_dir']   = join(join(datasets_root, dir_annex), 'train')
dataset_conf['train_mask_dir']    = join(join(datasets_root, 'labels'), 'train')
dataset_conf['val_image_dir']     = join(join(datasets_root, dir_annex), 'test')
dataset_conf['val_mask_dir']      = join(join(datasets_root, 'labels'), 'test')
dataset_conf['test_image_dir']    = join(join(datasets_root, dir_annex), 'test')
dataset_conf['test_mask_dir']     = join(join(datasets_root, 'labels'), 'test')

if dataset_conf['cropped']:
    crop_name = f"_crop{dataset_conf['crop_size']}_s{dataset_conf['stride']}"
    dataset_conf['train_image_dir_cropped']   = dataset_conf['train_image_dir'] + crop_name
    dataset_conf['train_mask_dir_cropped']    = dataset_conf['train_mask_dir'] + crop_name
    dataset_conf['val_image_dir_cropped']     = dataset_conf['val_image_dir'] + crop_name
    dataset_conf['val_mask_dir_cropped']      = dataset_conf['val_mask_dir'] + crop_name
    dataset_conf['test_image_dir_cropped']    = dataset_conf['test_image_dir'] + crop_name
    dataset_conf['test_mask_dir_cropped']     = dataset_conf['test_mask_dir'] + crop_name
############################################################################################################ 

model_conf['decoder']           = "Unet"
model_conf['encoder']           = "vgg19"
model_conf['encoder_weight']    = "imagenet"
model_conf['activation']        = "sigmoid"

training_conf['batch_size'] = 8
training_conf['epoch'] = 1
training_conf['lr'] = 5e-5
training_conf['weight_decay'] = 1e-2

task_conf = {}
task_conf['dataset_conf'] = dataset_conf
task_conf['model_conf'] = model_conf
task_conf['training_conf'] = training_conf
task_conf['augment_conf'] = augment_conf

prepare_data_step = False
train_step = False
test_step = True
email_step = True

steps = [prepare_data_step,train_step,test_step,email_step]

main_task(task_conf,steps,device)
