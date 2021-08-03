describe aws_ec2_instance(name: 'peer.review.02-webserver-vm-centos-2') do
  it { should be_running }
end

describe aws_security_group(group_name: 'web_server_sg') do
  it { should exist }
end
describe aws_security_group(group_name: 'web_server_sg') do
  it { should allow_in(port: 8080, ipv4_range: '0.0.0.0/0') }
end
# describe aws_ec2_instance('i-05eec675951a2c17b') do
#   it { should be_running }
# end