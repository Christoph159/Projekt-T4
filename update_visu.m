function update_visu(X_sp, Y_sp,x, y, psi, phi,roverl,roverb,rad_l,rad_b)
    coder.extrinsic('roverplot', 'rovertopview')
    roverplot(X_sp, Y_sp,x, y, psi,roverl,roverb);
    update_raeder(phi,roverl,roverb,rad_l,rad_b);
end
