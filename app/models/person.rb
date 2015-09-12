require 'matrix'

class Person < ActiveRecord::Base
    include LogisticRegression
    mattr_accessor :theta, instance_accessor: false do
        Matrix.zero(1, (2+1))
    end

    def self.train
        # SETUP
        # Number in training sample
        m = self.count.to_f
        # Number of features
        n = 2
        # Initialize thetas for each attribute plus the intercept
        @@theta ||= Matrix.zero(1, (n+1))
        # Load data in Matrix form for easier calculations 
        x = Matrix[*Person.pluck(1, :height, :weight)]
        y = Matrix.column_vector(Person.pluck(:gender))
        max_iterations = 10

        ## RUN
        max_iterations.times do
            z = x * @@theta.transpose
            h = z.collect { |row| LogisticRegression.sigmoid(row) }
            
            gradient = (1/m) * x.transpose * (h-y)
            unary_minus = h.collect { |row| 1-row }
            hessian = (1/m) * x.transpose * Matrix.diagonal(*h.to_a.flatten) * Matrix.diagonal(*unary_minus.to_a.flatten) * x
            
            @@theta = (@@theta.transpose - (hessian.inverse * gradient)).transpose
        end
    end

    def classify
        Person.train
        z = (Matrix[[1,self.height,self.weight]]*@@theta.transpose)[0,0]
        probability_is_a_man = 1 - LogisticRegression.sigmoid(-z)
        
        if probability_is_a_man >= 0.5
            self.gender = 1
            probability_is_a_man
        else
            self.gender = 0
            1 - probability_is_a_man
        end
    end
end