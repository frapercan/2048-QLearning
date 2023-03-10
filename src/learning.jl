mutable struct QLearning
	š®::Any # state space (assumes 1:nstates)
	š::Any # action space (assumes 1:nactions)
	Ī³::Any # discount
	Q::Any # action value function
	Ī±::Any # learning rate
	Ļµ::Any # Exploration rate
end

function lookahead(model::QLearning, s, a)
	return model.Q[s, a]
end

function update!(model::QLearning, s, a, r, sā²)
	Ī³, Q, Ī± = model.Ī³, model.Q, model.Ī±
	Q[s, a] += Ī± * (r + Ī³ * maximum(Q[sā², :]) - Q[s, a])
	update!(model, s, a, r, sā²)
	return model
end

function EpsilonGreedyExploration(model)
	š®, š, Q, Ļµ = model.š®, model.š, model.Q, model.Ļµ
	
	for a in š
		new_board, score_increasement = move(š®, a)
		rewards = calculate_rewards(š®, new_board, score_increasement)
		Q[š®, a] = rewards
	end

	if rand() < Ļµ
		a = rand(š)
	else
		a = argmax(a -> Q[š®, a], š)
	end

	for a in š
		println("Action: ",a, "Value: ", Q[š®, a])
	end

	println(" ")
	new_board, _ = move(š®, a)
	return new_board, Q, a
end


function initialize_Q_table_if_empty(model, board)
	for a in model.š
		if !haskey(model.Q, [board, a])
			model.Q[board, a] = 0
		end
	end
	return model
end