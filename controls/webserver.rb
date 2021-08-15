input('tomcat_service', value: 'enable')
input('tomcat_user', value: 'tomcat')
input('tomcat_group', value: 'tomcat')
input('catalina_home', value: '/opt/tomcat')


control 'tomcat.dedicated_user' do
  impact 1.0
  tag 'ID: 3.10-5/2.1'
  title 'The application server must run under a dedicated (operating-system) account that only has the permissions required for operation.'
  describe user(input('tomcat_user')) do
    it { should exist }
  end
  describe group(input('tomcat_group')) do
    it { should exist }
  end
end

control 'tomcat.dedicated_service' do
  impact 1.0
  tag 'ID: 3.10-5/2.1-1'
  title 'If not containerized, the application service must be installed properly.'
  describe service('tomcat') do
    before do
      skip if input('tomcat_service') == 'disable'
    end
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
  describe processes('tomcat') do
    before do
      skip if input('tomcat_service') == 'disable'
    end
    its('users') { should eq [input('tomcat_user')] }
  end
end

control 'webserver-01' do
  impact 0.7
  title 'Tomcat related compliance checks'
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
