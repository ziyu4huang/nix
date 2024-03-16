pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

pip install envpool torch-tb-profiler
pip install gymnasium[box2d]
#pip install opencv-python vizdoom
git clone --depth 1 https://github.com/Farama-Foundation/ViZDoom
pip install -e .

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ziyu4huang/.mujoco/mujoco210/bin


install D4RL
============

# 测试,创建 test_d4rl.py 并添加如下内容 vim test_d4rl.py
https://zhuanlan.zhihu.com/p/489475047


offline 
===========


python examples/atari/atari_dqn.py   --save-buffer-name atari_dqn.hdf5
python examples/offline/atari_bcq.py  --load-buffer-name atari_dqn.hdf5


###################

Warning: Flow failed to import. Set the environment variable D4RL_SUPPRESS_IMPORT_ERROR=1 to suppress this message.
No module named 'flow'
Warning: CARLA failed to import. Set the environment variable D4RL_SUPPRESS_IMPORT_ERROR=1 to suppress this message.
No module named 'carla'



Instructions for installing CARLA can be found here

nstructions for installing Flow can be found here. 
Make sure to install using the SUMO simulator, and add the flow repository to your PYTHONPATH once finished.


Build DGL
==============
change to venv

DGL_HOME=`pwd` PATH=$PATH:/usr/local/cuda-12.3/bin  bash script/build_dgl.sh -g

