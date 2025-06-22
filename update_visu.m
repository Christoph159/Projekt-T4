function update_visu(x, y, psi, phi, roverl, roverb, rad_l, rad_b, rover_radr, roverh)
    coder.extrinsic('roverplot', 'rovertopview', 'update_raeder')
    roverplot(x, y, psi, roverb, roverl, roverh, rover_radr);
    update_raeder(phi, roverl, roverb, rad_l, rad_b);
end
