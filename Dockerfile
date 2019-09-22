FROM heroku/miniconda

# Update conda
RUN conda update -y conda

# Grab environment file for starkit
RUN curl -O https://raw.githubusercontent.com/starkit/starkit/master/starkit_env3.yml

# Create conda environment for starkit
RUN conda env create -n starkit --file ./starkit_env3.yml

# Activate created environment 
RUN conda activate starkit

# Grab requirements.txt
# TODO: Remove commit tag from starkit when fixed & might need to install it in release phase
ADD ./interfaces/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip install -qr /tmp/requirements.txt



# Add the code of interfaces to /opt
ADD ./interfaces /opt/interfaces/
WORKDIR /opt/interfaces

# Download test grid in working dir (TODO: Put in release phase)
RUN wget https://zenodo.org/record/2557923/files/phoenix_t4000_10000_w3000_9000_r3000.h5?download=1 -O test_grid.h5



# Run the interactive_spectrum.ipynb as voila app
# TODO: Run interfaces/ dir as app & enhance its look by using voila templates
CMD voila --port=$PORT --no-browser interactive_spectrum.ipynb