class PokemonsController < ApplicationController
	def index
		@pokemons = Pokemon.all
	end

	def new
		@pokemon = Pokemon.new
	end

	def create
		@pokemon = Pokemon.create(post_params)
		@pokemon.health = 100
		@pokemon.level = 1
		@pokemon.trainer = current_trainer
		if @pokemon.save
			redirect_to trainer_path(current_trainer.id)
		else
			flash[:error] = "Pokemon not unique or empty!"
			redirect_to pokemons_new_path
		end
	end 

	def capture
		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer = current_trainer
		@pokemon.save
		redirect_to '/'
	end

	def damage
		@pokemon = current_trainer.pokemons.find(params[:id])
		@pokemon.health -= 10
		if @pokemon.health <= 0
			@pokemon.destroy
		else
			@pokemon.save
		end
		redirect_to trainer_path(current_trainer.id)
	end

#	def destroy
#		@pokemon = Pokemon.find(params[:id]).delete
#		@pokemon.save
#	end

private
	def post_params
		params.require(:pokemon).permit(:name)
	end 
end
