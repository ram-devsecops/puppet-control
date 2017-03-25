Facter.add('puppet_role') do
  setcode do
    hostname = Facter.value(:hostname).split('-')[0]
  end
end
