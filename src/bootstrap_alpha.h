/*
 * bootstrap_alpha, bootstrap_alpha_nonparametric :
 * Bootstrap Krippendorff's Alpha
 * Copyright (C) 2017  Alexander Staudt
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, a copy is available at
 * https://www.r-project.org/Licenses/GPL-2
 */

#ifndef BOOTSTRAP_ALPHA_H
#define BOOTSTRAP_ALPHA_H

#include <vector>
#include <string>

/* bootstrap functions */
extern int bootstrap_alpha(
    const double D_e,
    const std::vector<double> &reliability_data,
    const int nC,
    const int nU,
    const std::vector<double> &coding_values,
    const std::vector<double> &contributions,
    const int metric,
    const int bootstraps,
    const unsigned long seed[6],
    const int n_threads,
    std::vector<double> &alphas);

extern int bootstrap_alpha_nonparametric(
    const std::vector<double> &reliability_data,
    const int nC,
    const int nU,
    const std::string &metric,
    const int bootstraps,
    const unsigned long seed[6],
    const int n_threads,
    std::vector<double> &alphas);

#endif
