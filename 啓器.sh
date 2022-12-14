xhost +local:docker
XAUTH=/tmp/.docker.xauth
	if [ ! -f $XAUTH ]
	then
	xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
	if [ ! -z "$xauth_list" ]
	then
		echo $xauth_list | xauth -f $XAUTH nmerge -
	else
		touch $XAUTH
	fi
chmod a+r $XAUTH
fi

export contName=simreal
export mtrt=/media/yyr
docker run -d --rm -p 5555:9999 --gpus all \
	-v $mtrt/program/mujoco:/sr \
	--env DISPLAY=$DISPLAY \
	--env "QT_X11_NO_MITSHM=1" \
	-v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--env "XAUTHORITY=$XAUTH" \
	-v "$XAUTH:$XAUTH" \
	--name $contName \
	sim_real:latest \
	sleep infinity
# 肰後「docker exec -it simreal bash」以入
# 列所有容器：docker ps
# 止：docker stop <容器戠：但无重名，頭四位即可>
