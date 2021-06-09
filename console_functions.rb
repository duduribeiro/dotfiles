def rr
  reload!
end

def m(object)
  object.methods - Object.methods
end

def lm(object)
  object.methods - object.class.superclass.instance_methods
end

def skflush
  Sidekiq.redis { |conn| conn.flushdb }
end

alias :sflush :skflush

def cpp(input)
  IO.popen('pbcopy', 'w') { |pipe| pipe.puts(input) }
  input
end

def bm(&block)
  Benchmark.realtime(&block)
end

def explain(query)
  puts ActiveRecord::Base.connection.execute("explain analyze #{query.to_sql}").values
end

def stack_trace
  caller.reject { _1['gems/'] }
end

alias :stt :stack_trace
alias :stack :stack_trace
alias :stacktrace :stack_trace

class StringToRoute

  attr_reader :request, :url, :verb

  def initialize(request)
    @request = request
    @url = request.original_fullpath
    @verb = request.request_method.downcase
  end

  def routes
    Rails.application.routes.routes.to_a
  end

  def recognize_path
    Rails.application.routes.recognize_path(url, method: get_verb)
  end

  def process
    _recognize_path = recognize_path
     routes.select do |hash|
       if hash.defaults == _recognize_path
         hash
       end
     end
  end

  def get_verb
    verb.to_sym
  end

  def path
    "#{verb}_#{process.name}"
  end
end
