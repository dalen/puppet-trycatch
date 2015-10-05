Puppet::Functions.create_function(:catch) do
  dispatch :catch do
    param 'Array[Any, 2, 2]', :arg
    optional_repeated_param 'String', :exceptions
    block_param
  end

  def catch(arg, *exceptions)
    if arg[1]
      unless exceptions.empty?
        fail arg[1]['exception'] unless exceptions.include? arg[1]['class']
      end
      yield arg[1]
    else
      arg[0]
    end
  end
end
