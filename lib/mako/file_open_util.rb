module FileOpenUtil
  # Opens and reads the passed in file. Thanks to the following article
  # for explaining how to define a method on the included singleton class:
  # https://6ftdan.com/allyourdev/2015/02/24/writing-methods-for-both-class-and-instance-levels/
  #
  # @param [String] resource the path to the resource
  # @return [String] the opened resource
  def self.included(base)
    def base.load_resource(resource)
      File.open(resource, 'rb', encoding: 'utf-8', &:read)
    end
  end

  def load_resource(resource)
    self.class.load_resource(resource)
  end
end
