require 'spec_helper'

describe OpenSSLExtensions do
  context 'check_dependencies!' do
    context 'with OpenSSL extensions installed' do
      before(:each) do
        OpenSSLExtensions.should_receive(:require).with('openssl').and_return(true)
      end

      it 'does not exit' do
        OpenSSLExtensions.should_receive(:exit).never
        OpenSSLExtensions.check_dependencies!
      end

      it 'does not write to STDERR' do
        $stderr.should_receive(:puts).never
        OpenSSLExtensions.check_dependencies!
      end
    end

    context 'without OpenSSL extensions installed' do
      before(:each) do
        OpenSSLExtensions.should_receive(:require).with('openssl').and_raise(LoadError)

        $stderr.stub!(:puts)
        OpenSSLExtensions.stub!(:exit)
      end

      it 'write a message on STDERR' do
        $stderr.should_receive(:puts).with("OpenSSLExtensions requires Ruby to be compiled with OpenSSL support.")
        OpenSSLExtensions.check_dependencies!
      end

      it 'exits with error' do
        OpenSSLExtensions.should_receive(:exit).with(1)
        OpenSSLExtensions.check_dependencies!
      end
    end
  end
end
