# frozen_string_literal: true

module URI
  class Generic
    # Compares parsed URI with a base URI and adds the host section, if needed
    #
    # @param base_uri [URI]
    def absolutize!(base_uri)
      base_uri.host == host ? to_s : base_uri.merge(self).to_s
    end
  end
end
