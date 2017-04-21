class Object
  def read(client : TCPSocket, bytes : Int32) : String
    data = Bytes.new(bytes)
    bytes_read = client.read(data)
    String.new(data[0, bytes_read]).strip
  end
end
