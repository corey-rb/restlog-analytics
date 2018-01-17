@report

node :report do
    @report.map do |data|
        { :app => data[0], :count => data[1] }
    end
end
