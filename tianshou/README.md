pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install envpool torch-tb-profiler
pip install gymnasium[box2d]
#pip install opencv-python vizdoom
git clone --depth 1 https://github.com/Farama-Foundation/ViZDoom
pip install -e .

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ziyu4huang/.mujoco/mujoco210/bin

