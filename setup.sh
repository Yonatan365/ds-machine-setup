sudo apt-get -y upgrade gcc g++ make git curl vim tmux
mkdir downloads
cd downloads
wget "https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh" -O "Anaconda3-5.0.1-Linux-x86_64.sh"
bash "Anaconda3-5.0.1-Linux-x86_64.sh" -b 
echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> ~/.bashrc 
conda update -y --all
conda install -y tensorflow theano keras
pip install xgboost

echo "[global]
device = cpu
floatX = float32" > ~/.theanorc

mkdir ~/.keras
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}' > ~/.keras/keras.json

# configure jupyter and prompt for password
jupyter notebook --generate-config
jupass=`python -c "from notebook.auth import passwd; print(passwd())"`
echo "c.NotebookApp.password = u'"$jupass"'" >> $HOME/.jupyter/jupyter_notebook_config.py
echo "c = get_config()
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 5000" >> $HOME/.jupyter/jupyter_notebook_config.py

# clone fast.ai course repo
cd ~
mkdir ds
cd ds
git clone https://github.com/fastai/courses.git
echo "\"jupyter notebook\" will start Jupyter on port 5000"
echo "If you get an error instead, try restarting your session so your $PATH is updated"
