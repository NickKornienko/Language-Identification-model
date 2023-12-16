# Language-Identification-model
This repository contains the code and instructions for building a TensorFlow language recognition model. The model will distinguish audio spoken between English, French and Spanish. For a complete demo checkout https://youtu.be/9-QbkYQmYCQ

## Data Source
To train a model capable of distinguishing between 3 languages, we would need a good amount of audio data in all 3 languages. T
We were able to find all the required data  at https://commonvoice.mozilla.org/

### Data and its Version
- English Data
    - Common Voice Delta Segment 14.0
- French
    - Common Voice Corpus 1
- Spanish
    - Common Voice Delta Segment 12.0
Download all 3 files unzip them and save them in the following order

parent_folder/english/all_eng_files
parent_folder/french/all_fr_files
parent_folder/spanish/all_es_files

## Data preprocessing
- After you have all the files in the above format, we can start with data preprocessing. Firstly we'll arrange all the files in proper subfolders, such that they can be uploaded collab ( no single folder can have more than 1000 files, this is a Google Collab limitation)
### Data Preparation
- To achieve this run "**movefile.py**" and change the data source inside to it to your directory
- This code will make subdirectories inside each of the language folders such that each subfolder will have atmost 100 files

As we cannot directly work with audio files, we would need to represent them in terms of numbers so that we can work with them to perform EDA, generate features etc.

To achieve this you can run "**FormatingAudioData.ipynb**".

This file will go through all the audio files, represent them as numbers, get their meta data such as sampling rate, audio length and MFCC for each file. This file has 2 types of outputs, one will be csv and pickle file which contains the audio data, sampling rate, audio length and labels and the other will be the MFCC representation of all audio files and their labels as pickle and csv. (Note if you want to perform any analysis on the audio data, use the pickle files for transformation). You can run both tasks independently (Note be careful with the pickle file size as the pickle file size for the first output can be over 20,30 GB)

### EDA and Data Cleaning
This task is being performed inside "**LanguageUnderstanding_Preprocessing.ipynb**". 

This step help us identify any data quality issues which might be present inside our data such as missing or corrupted data, class imbalance. This notebook also generates the MFCC values for all files (incase you didn't run it earlier), after which the file has evidence that we use to determine if MFCC values can be used for training the data.

## Training and Evaluation
The input for this step will be the pickle file which has all the MFCC values (n_mfcc=40) for all, the training is being handled by "**LanguageUnderstanding_Training.ipynb**".

This file handles the class imbalance issue, creates a train test split of 80-20 ratio, and builds and tries 4 different models a 3 and 5 layer RNN and 3 and 5 layer 1D CNN. In our case the 5 layer 1D CNN works best, the notebook also contains various statistical and visualization techniques for evaluating the performance of the model.

"**255mode_5layerCNN.h5**" This is the finalized model for this project. (It accepts input of the shape n,40,1)
"**language_le.pkl**" This is the label encoder used for training purpose

## Inference and Deployment

Inference is using the trained model to make predictions, this is being demonstrated by "**LanguageUnderstanding_Inferencec.ipynb**" .

We have 2 different types of inference that we demonstrate in this notebook first is local inference, which is where we just load the trained model and use it for making predictions. The second one is the ML Endpoint inference, in this we deploy our model on Azure ML Endpoint, and use the endpoint for making the predictions.

Some files which you'll need for Making the Azure ML Endpoint
- **Deployment Steps.docx** this file contains the instructions and steps for deploying your model on Azure ML
- **Dockerfile** creating image for a custom Azure ML environment, in which our model will run
- **score.py** the scoring script used by our endpoint to handle incoming requests and make predictions on them


Other Project Artifacts:
- **LangugeRecReport.pdf**: final report of the project
- **255Project.pptx:** Presentation PPT
- **all_data.pkl:** The pickle file which contains the MFCC values and labels for all the audio files, this is the file you can use if you want to rerun the training notebook directly
- audio_file: contains sample audio files which you can use for testing/model inference

Presentation & Demo Video: https://youtu.be/9-QbkYQmYCQ
