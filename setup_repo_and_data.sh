# Define variables
lesion_type="ma"
image_type="Denoised/all_4096"
git_repo="https://github.com/ademgunesen/kamyonculuk.git"
crop_size="1152"

git clone $git_repo
cd kamyonculuk
pip install -r requirements.txt
echo 'Repo cloned and requirements installed'

# Define the Python file name
python_file="drive_mounter.py"
# Use echo to write Python code into the Python file
echo "#!/usr/bin/env python3" > "$python_file"
echo "" >> "$python_file"
echo "from google.colab import drive" >> "$python_file"
echo "drive.mount('/content/drive')" >> "$python_file"

# Make the Python script executable
chmod +x "$python_file"
# Warn the user that they need to mount their Google Drive
echo "Please mount your Google Drive by running the following command:"
echo "from google.colab import drive"
echo "drive.mount('/content/drive')"
echo "or copy drive_mounter.py to your notebook and run it."
echo "Please press Enter if you have mounted your Google Drive."
read
# wait enough time for mounting process
echo "Waiting for 5 seconds..."
sleep 5
# Check if the Google Drive is mounted
if [ ! -d "/content/drive" ]; then
  echo "Google Drive is not mounted. Please mount it and try again."
  exit 1
fi
echo "Google Drive is mounted successfully."
# create a directory for the data under the parent directory of the repo
# if the directory already exists no error will be thrown
cd ..
cd ..
mkdir -p "/content/square"
# create a directory for the image_type
mkdir -p "/content/square/$image_type"
mkdir -p "/content/square/$image_type/train"
mkdir -p "/content/square/$image_type/test"
mkdir -p "/content/square/$image_type/val"
# create a directory for the lesion_type
mkdir -p "/content/square/labels/train/$lesion_type"
mkdir -p "/content/square/labels/test/$lesion_type"
mkdir -p "/content/square/labels/val/$lesion_type"
# create a directory for the cropped lesion type
mkdir -p "/content/square/labels/train_crop$crop_size""_s$crop_size"
mkdir -p "/content/square/labels/test_crop$crop_size""_s$crop_size"
mkdir -p "/content/square/labels/val_crop$crop_size""_s$crop_size"
# copy the full size label data from the Google Drive to the local directory
echo "Copying data from Google Drive to local directory..."
echo "Copying labels..."
echo "Copying labels test..."
cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/labels/test/" "/content/square/labels/test/$lesion_type"
echo "Copying labels train..."
cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/labels/train/" "/content/square/labels/train/$lesion_type"
echo "Copying labels val..."
cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/labels/val/" "/content/square/labels/val/$lesion_type"
# copy the full size image data from the Google Drive to the local directory
echo "Copying images..."
echo "Copying images test..."
cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/$image_type/" "/content/square/$image_type/test"
echo "Copying images train..."
cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/$image_type/" "/content/square/$image_type/train"
echo "Copying images val..."
cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/$image_type/" "/content/square/$image_type/val"
# copy the cropped image data from the Google Drive to the local directory
# crop_dir="_crop$crop_size""_s$crop_size"
# echo "Copying cropped images..."
# echo "Copying images test$crop_dir..."
# cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/$image_type/" "/content/square/$image_type/test$crop_dir"
# echo "Copying images train$crop_dir..."
# cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/$image_type/" "/content/square/$image_type/train$crop_dir"
# echo "Copying images val$crop_dir..."
# cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/$image_type/" "/content/square/$image_type/val$crop_dir"

# echo "Copying cropped labels..."
# echo "Copying labels test$crop_dir..."
# cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/labels/test$crop_dir/" "/content/square/labels/test$crop_dir/$lesion_type"
# echo "Copying labels train$crop_dir..."
# cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/labels/train$crop_dir/" "/content/square/labels/train$crop_dir/$lesion_type"
# echo "Copying labels val$crop_dir..."
# cp -r "/content/drive/MyDrive/IDRiD_Datasets/Square_Format/labels/val$crop_dir/" "/content/square/labels/val$crop_dir/$lesion_type"
# echo "Data copied successfully."
# echo "You can now run the training script!!!!!!!!!!!!!!!!!!!!111 <3"