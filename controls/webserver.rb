
# describe aws_ec2_instance('i-05eec675951a2c17b') do
#   it { should be_running }
# end

# Add two control, 1 for AWS resources, 2nd for weserver (like tomcat port etc, service installed)



control 'webserver-01' do
  impact 0.7
  title 'Tomcat releated compliance checks'
  desc 'Tomcat releated compliance checks'
  describe package('java-1.8.0-openjdk') do
    it { should be_installed }
  end
  describe command('curl http://localhost:8080') do
    its('stdout') { should match(%r{Apache Tomcat}) }
  end

  describe port(8080) do
    it { should be_listening }
  end
end