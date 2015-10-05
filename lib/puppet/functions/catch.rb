Puppet::Functions.create_function(:catch) do
  dispatch :catch do
    param 'Array[Any, 2, 2]', :arg
    block_param
  end

  def catch(arg)
    if arg[1]
      yield arg[1]
    else
      arg[0]
    end
  end
end
