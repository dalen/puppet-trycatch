# Call a lambda and rescue exceptions from it.
#
# @example Using try/catch
#
#     # Prints the exception message from assert_type failure
#     notice(try() || {
#       assert_type('String', 1)
#     }.catch |$exception| {
#       $exception['message']
#     })
#
Puppet::Functions.create_function(:try) do
  dispatch :try do
    block_param
  end

  def try
    [yield, nil]
  rescue
    [nil, { 'class' => $!.class.to_s, 'message' => $!.message, 'exception' => $! }]
  end
end
