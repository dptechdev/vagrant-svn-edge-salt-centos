createdir:
  cmd.run:
    - name: sudo mkdir /opt/collabnet && sudo chown vagrant /opt/collabnet
    - unless: ls /opt/collabnet

expand:
  cmd.run:
    - name: tar zxf /srv/salt/CollabNetSubversionEdge-4.0.13_linux-x86_64.tar.gz -C /opt/collabnet
    - user: vagrant
    - group: vagrant
    - creates: /opt/collabnet/csvn

firewall:
  iptables.insert:
    - position: 4
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match:
      - state
      - comment
    - comment: "Allow HTTP"
    - connstate: NEW
    - proto: tcp
    - dports:
      - 3343
      - 4434
      - 80
    - save: true

install:
  cmd.run:
    - name: sudo -E /opt/collabnet/csvn/bin/csvn install
    - user: vagrant
    - env: 
      - JAVA_HOME: '/usr/java/default'
    - unless: ls /opt/collabnet/csvn/data/conf/csvn.conf

start:
  cmd.run:
    - name: /opt/collabnet/csvn/bin/csvn start
    - user: vagrant
    - env: 
      - JAVA_HOME: '/usr/java/default'
    - unless: /opt/collabnet/csvn/bin/csvn status >status.txt && grep 'is running' status.txt && rm status.txt
