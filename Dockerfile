FROM mcr.microsoft.com/azureml/openmpi3.1.2-ubuntu18.04
ENV AZUREML_CONDA_ENVIRONMENT_PATH /azureml-envs/tensorflow-2.14
# Create conda environment
RUN conda create -p $AZUREML_CONDA_ENVIRONMENT_PATH \
    python=3.10 pip=23.1.2
# Prepend path to AzureML conda environment
ENV PATH $AZUREML_CONDA_ENVIRONMENT_PATH/bin:$PATH
# Install pip dependencies
RUN pip install 'psutil~=5.8.0' \
                                          'Pillow' \
                                          'pandas==1.5.3' \
                                          'scipy==1.11.4' \
                                          'numpy==1.23.5' \
                                          'ipykernel~=6.0' \
                                          'azureml-core~=1.54.0' \
                                          'azureml-defaults~=1.54.0' \
                                          'azureml-mlflow==1.54.0' \
                                          'azureml-telemetry==1.54.0' \
                                          'tensorflow==2.14.0'
                                          
                          
# This is needed for mpi to locate libpython
ENV LD_LIBRARY_PATH $AZUREML_CONDA_ENVIRONMENT_PATH/lib:$LD_LIBRARY_PATH