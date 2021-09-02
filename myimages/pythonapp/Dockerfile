FROM  python
#  we are pulling docker python based image from docker hub 
# if image not present then only pull it 
# FROm always as parent image 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com
# optional field but just for sharing image designer info 
RUN  mkdir /mycode 
# run  means shell access to container during image build time 
COPY cisco.py  /mycode/cisco.py 
# copy code from CLient machine to Docker engine during build time
CMD  ["python","/mycode/cisco.py"]
# CMD means default process setting 
# this will not be executing during image build time 
# ashu:v1 --- docker run -itd --name x1  ashu:v1  